import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["userSelect", "exchangeSelect", "assetList"]

  connect() {
    this.exchangeSelectTarget.disabled = true
    this.assetListTarget.innerHTML = '<p class="text-muted">请先选择交易所</p>'
  }

  // 防抖函数
  debounce(fn, wait) {
    let timeout;
    return (...args) => {
      clearTimeout(timeout);
      timeout = setTimeout(() => fn(...args), wait);
    };
  }

  // async userChanged() {
  //   console.log('user changed.............')
  //   const userId = this.userSelectTarget.value
  //   this.exchangeSelectTarget.disabled = true
  //   this.assetListTarget.innerHTML = '<p class="text-muted">请先选择交易所</p>'

  //   if (!userId) {
  //     this.exchangeSelectTarget.innerHTML = '<option value="">请选择用户</option>'
  //     return
  //   }

  //   try {
  //     const response = await fetch(`/trades/exchanges_for_user/${userId}`)
  //     const userExchanges = await response.json()

  //     this.exchangeSelectTarget.innerHTML = '<option value="">请选择交易所</option>' +
  //       userExchanges.map(ue => `<option value="${ue.id}">${ue.exchange_name}</option>`).join('')
  //     this.exchangeSelectTarget.disabled = false
  //   } catch (error) {
  //     console.error("加载交易所失败:", error)
  //     this.showError("无法加载交易所，请重试")
  //   }
  // }

  userChanged(event) {
    console.log("userChanged triggered:", this.userSelectTarget.value, event);
    const userId = this.userSelectTarget.value;
    this.exchangeSelectTarget.disabled = true;
    this.assetListTarget.innerHTML = '<p class="text-muted">请先选择交易所</p>';

    if (!userId) {
      this.exchangeSelectTarget.innerHTML = '<option value="">请选择用户</option>';
      return;
    }

    this.fetchExchanges(userId);
  }

  async fetchExchanges(userId) {
    console.log("Fetching exchanges for user:", userId);
    try {
      const response = await fetch(`/trades/exchanges_for_user/${userId}`);
      if (!response.ok) throw new Error(`HTTP error ${response.status}`);
      const userExchanges = await response.json();

      this.exchangeSelectTarget.innerHTML = '<option value="">请选择交易所</option>' +
        userExchanges.map(ue => `<option value="${ue.id}">${ue.exchange_name}</option>`).join('');
      this.exchangeSelectTarget.disabled = userExchanges.length === 0;
    } catch (error) {
      console.error("加载交易所失败:", error);
      this.showError("无法加载交易所，请重试");
    }
  }

  exchangeChanged() {
    const userExchangeId = this.exchangeSelectTarget.value
    console.log("Exchange changed:", userExchangeId);
    if (!userExchangeId) {
      document.getElementById("asset-list").innerHTML = '<p class="text-muted col-12">请先选择交易所</p>'
      return
    }

    const frame = document.getElementById("asset-list");
    frame.src = `/trades/assets_for_user_exchange/${userExchangeId}`;
    console.log("Turbo Frame src set:", frame.src);
  }

  async exchangeChanged_back() {
    const userExchangeId = this.exchangeSelectTarget.value
    this.assetListTarget.innerHTML = '<p class="text-muted">加载中...</p>'

    if (!userExchangeId) {
      this.assetListTarget.innerHTML = '<p class="text-muted">请先选择交易所</p>'
      return
    }

    try {
      const response = await fetch(`/trades/assets_by_user_exchange/${userExchangeId}`)
      const assets = await response.json()

      if (assets.length === 0) {
        this.assetListTarget.innerHTML = '<p class="text-muted">该交易所无可用资产</p>'
        return
      }

      this.assetListTarget.innerHTML = assets.map(asset => `
        <div class="card mb-2">
          <div class="card-body d-flex justify-content-between align-items-center p-2">
            <div>
              <h5 class="card-title mb-1">${asset.asset}</h5>
              <p class="card-text text-muted">余额: ${asset.free} ${asset.asset}</p>
            </div>
            <div>
              <button class="btn btn-success btn-sm me-2" data-bs-toggle="collapse" data-bs-target="#trade-form-${asset.asset}" aria-expanded="false">交易</button>
            </div>
          </div>
          <div class="collapse mb-2" id="trade-form-${asset.asset}">
            <div class="card card-body">
              <form class="row" data-action="submit->open-trade#submitTrade" data-asset="${asset.asset}">
                <div class="mb-3 col-sm-3">
                  <label class="form-label fw-bold">方向</label>
                  <select name="side" class="form-select" required>
                    <option value="BUY">买入</option>
                    <option value="SELL">卖出</option>
                  </select>
                </div>
                <div class="mb-3 col-sm-3">
                  <label class="form-label fw-bold">订单类型</label>
                  <select name="order_type" class="form-select" required>
                    <option value="LIMIT">现价</option>
                    <option value="MARKET">市价</option>
                  </select>
                </div>
                <div class="mb-3 col-sm-3">
                  <label class="form-label fw-bold">价格</label>
                  <input type="number" name="price" class="form-control" step="any" value="${asset.price || ''}" required>
                </div>
                <div class="mb-3 col-sm-3">
                  <label class="form-label fw-bold">数量</label>
                  <input type="number" name="quantity" class="form-control" step="any" required>
                </div>
                <div class="text-end">
                  <button type="submit" class="btn btn-primary">提交</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      `).join('')
    } catch (error) {
      console.error("加载资产失败:", error)
      this.showError("无法加载资产，请重试")
    }
  }

  async submitTrade(event) {
    event.preventDefault()
    const form = event.target
    const userExchangeId = this.exchangeSelectTarget.value
    const asset = form.dataset.asset
    const formData = new FormData(form)
    const tradeData = {
      user_exchange_id: userExchangeId,
      asset: asset,
      side: formData.get("side"),
      order_type: formData.get("order_type"),
      price: formData.get("price"),
      quantity: formData.get("quantity")
    }

    try {
      const response = await fetch("/trades/open_create", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ trade: tradeData })
      })

      if (!response.ok) {
        const data = await response.json()
        throw new Error(data.error || "创建交易失败")
      }

      this.showSuccess("交易创建成功")
      form.reset()
      const collapse = bootstrap.Collapse.getInstance(form.closest(".collapse"))
      collapse.hide()
    } catch (error) {
      console.error("创建交易失败:", error)
      this.showError(error.message || "无法创建交易，请重试")
    }
  }

  showError(message) {
    const modal = new bootstrap.Modal(document.getElementById("errorModal"), { keyboard: true })
    document.getElementById("modal-error-message").textContent = message
    modal.show()
  }

  showSuccess(message) {
    const alert = document.createElement("div")
    alert.className = "alert alert-success alert-dismissible fade show"
    alert.innerHTML = `
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `
    this.element.prepend(alert)
    setTimeout(() => alert.remove(), 3000)
  }
}