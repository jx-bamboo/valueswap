import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["user", "exchange", "coin"]

  connect() {
    // 初始化时检查用户选择状态
    this.updateExchangeOptions()
    console.log("----------Hello from Stimulus")
  }

  async updateExchangeOptions() {
    const userId = this.userTarget.value
    this.exchangeTarget.disabled = true
    this.coinTarget.disabled = true
    this.clearOptions(this.exchangeTarget, "请选择交易所")
    this.clearOptions(this.coinTarget, "请选择交易所")

    if (userId) {
      try {
        const response = await fetch(`/user_exchange_coins/exchanges_for_user/${userId}`)
        const exchanges = await response.json()

        this.populateOptions(this.exchangeTarget, exchanges, "请选择交易所")
        this.exchangeTarget.disabled = false
      } catch (error) {
        console.error("加载交易所失败:", error)
        this.exchangeTarget.innerHTML = '<option value="">加载失败，请重试</option>'
      }
    }
  }

  async updateCoinOptions() {
    const exchangeId = this.exchangeTarget.value
    this.coinTarget.disabled = true
    this.clearOptions(this.coinTarget, "请先选择交易所")

    if (exchangeId) {
      try {
        const response = await fetch(`/user_exchange_coins/coins_for_exchange/${exchangeId}`)
        const coins = await response.json()

        this.populateOptions(this.coinTarget, coins, "请选择币种")
        this.coinTarget.disabled = false
      } catch (error) {
        console.error("加载币种失败:", error)
      }
    }
  }

  clearOptions(select, promptText) {
    select.innerHTML = `<option value="">${promptText}</option>`
  }

  populateOptions(select, items, promptText) {
    select.innerHTML = `<option value="">${promptText}</option>` +
      items.map(item => `<option value="${item.id}">${item.name}</option>`).join("")
  }
}