// app/javascript/controllers/exb_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["user", "exchange"]

  connect() {
    console.log("Exb controller connected")
    this.updateExchangeOptions()
  }

  updateExchangeOptions() {
    const userId = this.userTarget.value
    const exchangeSelect = this.exchangeTarget

    // 清空并禁用交易所选项
    exchangeSelect.innerHTML = '<option value="">请选择交易所</option>'
    exchangeSelect.disabled = true

    if (!userId) return

    // AJAX 获取用户绑定的交易所
    fetch(`/user_exchanges/by_user?user_id=${userId}`, {
      headers: { "Accept": "application/json" }
    })
      .then(response => response.json())
      .then(data => {
        if (data.length > 0) {
          data.forEach(exchange => {
            const option = document.createElement("option")
            option.value = exchange.id
            option.text = exchange.name || `交易所账户 ${exchange.id}`
            exchangeSelect.appendChild(option)
          })
          exchangeSelect.disabled = false
        } else {
          exchangeSelect.innerHTML = '<option value="">无可用交易所</option>'
        }
      })
      .catch(error => {
        console.error("Error fetching exchanges:", error)
        exchangeSelect.innerHTML = '<option value="">加载失败</option>'
      })
  }
}