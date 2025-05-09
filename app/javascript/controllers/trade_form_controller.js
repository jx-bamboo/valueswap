// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = [
//     "userSelect",
//     "exchangeSelect",
//     "coinSelect",
//     "price",
//     "quantity",
//     "totalAmount",
//     "orderSummary",
//     "balanceAmount",
//     "priceAmount"
//   ]

//   connect() {
//     this.exchangeSelectTarget.disabled = true
//     this.coinSelectTarget.disabled = true
//     this.clearCoinInfo()
//   }

//   async userChanged() {
//     const userId = this.userSelectTarget.value
//     this.exchangeSelectTarget.disabled = true
//     this.coinSelectTarget.disabled = true
//     this.clearCoinInfo()

//     if (!userId) {
//       this.exchangeSelectTarget.innerHTML = '<option value="">请选择用户</option>'
//       this.coinSelectTarget.innerHTML = '<option value="">请先选择交易所</option>'
//       return
//     }

//     try {
//       const response = await fetch(`/trades/exchanges_for_user/${userId}`)
//       const userExchanges = await response.json()

//       this.exchangeSelectTarget.innerHTML = '<option value="">请选择交易所</option>' +
//         userExchanges.map(ue => `<option value="${ue.id}">${ue.exchange_name}</option>`).join('')
//       this.exchangeSelectTarget.disabled = false

//       this.coinSelectTarget.innerHTML = '<option value="">请先选择交易所</option>'
//     } catch (error) {
//       console.error("加载交易所失败:", error)
//       this.element.querySelector('#error-message').textContent = '加载交易所失败，请重试'
//     }
//   }

//   async exchangeChanged() {
//     const userExchangeId = this.exchangeSelectTarget.value
//     this.coinSelectTarget.disabled = true
//     this.clearCoinInfo()

//     if (!userExchangeId) {
//       this.coinSelectTarget.innerHTML = '<option value="">请先选择交易所</option>'
//       return
//     }

//     try {
//       const response = await fetch(`/trades/coins_for_user_exchange/${userExchangeId}`)
//       const coins = await response.json()

//       this.coinSelectTarget.innerHTML = '<option value="">请选择币种</option>' +
//         coins.map(coin => `<option value="${coin.id}">${coin.symbol}</option>`).join('')
//       this.coinSelectTarget.disabled = false
//     } catch (error) {
//       console.error("加载币种失败:", error)
//       this.element.querySelector('#error-message').textContent = '无法加载币种，请重试'
//     }
//   }

//   async coinChanged() {
//     const userExchangeId = this.exchangeSelectTarget.value
//     const coinId = this.coinSelectTarget.value
//     this.clearCoinInfo()

//     if (!userExchangeId || !coinId) {
//       return
//     }

//     try {
//       this.balanceAmountTarget.textContent = '加载中...'
//       this.priceAmountTarget.textContent = '加载中...'
//       const response = await fetch(`/trades/coin_info/${userExchangeId}/${coinId}`)
//       const data = await response.json()
      
//       if (data.error) {
//         throw new Error(data.error)
//       }
  
//       this.balanceAmountTarget.textContent = `${data.balance}`
//       this.priceAmountTarget.textContent = `${data.price} USDT`
//       document.getElementById('trade_price').value = data.price
//     } catch (error) {
//       console.error("加载币种信息失败:", error)
//       this.balanceAmountTarget.textContent = '错误'
//       this.priceAmountTarget.textContent = '错误'
//       const modal = new bootstrap.Modal(document.getElementById('errorModal'))
//       document.getElementById('modal-error-message').textContent = error.message || '无法加载币种信息，请重试'
//       modal.show()
//     }
//   }

//   updateTotal() {
//     const price = parseFloat(this.priceTarget.value) || 0
//     const quantity = parseFloat(this.quantityTarget.value) || 0
//     const total = (price * quantity).toFixed(2)
//     this.totalAmountTarget.textContent = total
//     this.orderSummaryTarget.style.display = total > 0 ? "block" : "none"
//   }

//   clearCoinInfo() {
//     this.balanceAmountTarget.textContent = ''
//     this.priceAmountTarget.textContent = ''
//   }
// }

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "userSelect",
    "exchangeSelect",
    "coinSelect",
    "price",
    "quantity",
    "totalAmount",
    "orderSummary",
    "balanceAmount",
    "priceAmount"
  ]

  connect() {
    // 检查初始值，触发更新
    if (this.userSelectTarget.value) {
      this.userChanged()
    }
    if (this.exchangeSelectTarget.dataset.selected) {
      this.exchangeSelectTarget.value = this.exchangeSelectTarget.dataset.selected
      this.exchangeChanged()
    }
    if (this.coinSelectTarget.dataset.selected) {
      this.coinSelectTarget.value = this.coinSelectTarget.dataset.selected
      this.coinChanged()
    }
    this.updateTotal()
  }

  async userChanged() {
    const userId = this.userSelectTarget.value
    this.exchangeSelectTarget.disabled = true
    this.coinSelectTarget.disabled = true
    this.clearCoinInfo()

    if (!userId) {
      this.exchangeSelectTarget.innerHTML = '<option value="">请选择用户</option>'
      this.coinSelectTarget.innerHTML = '<option value="">请先选择交易所</option>'
      return
    }

    try {
      const response = await fetch(`/trades/exchanges_for_user/${userId}`)
      if (!response.ok) throw new Error(`HTTP error ${response.status}`)
      const userExchanges = await response.json()

      const selectedId = this.exchangeSelectTarget.dataset.selected
      this.exchangeSelectTarget.innerHTML = '<option value="">请选择交易所</option>' +
        userExchanges.map(ue => `<option value="${ue.id}" ${ue.id == selectedId ? 'selected' : ''}>${ue.exchange_name}</option>`).join('')
      this.exchangeSelectTarget.disabled = false

      this.coinSelectTarget.innerHTML = '<option value="">请先选择交易所</option>'
      if (selectedId) {
        this.exchangeChanged()
      }
    } catch (error) {
      console.error("加载交易所失败:", error)
      this.element.querySelector('#error-message').textContent = '加载交易所失败，请重试'
    }
  }

  async exchangeChanged() {
    const userExchangeId = this.exchangeSelectTarget.value
    this.coinSelectTarget.disabled = true
    this.clearCoinInfo()

    if (!userExchangeId) {
      this.coinSelectTarget.innerHTML = '<option value="">请先选择交易所</option>'
      return
    }

    try {
      const response = await fetch(`/trades/coins_for_user_exchange/${userExchangeId}`)
      if (!response.ok) throw new Error(`HTTP error ${response.status}`)
      const coins = await response.json()

      const selectedId = this.coinSelectTarget.dataset.selected
      this.coinSelectTarget.innerHTML = '<option value="">请选择币种</option>' +
        coins.map(coin => `<option value="${coin.id}" ${coin.id == selectedId ? 'selected' : ''}>${coin.symbol}</option>`).join('')
      this.coinSelectTarget.disabled = false

      if (selectedId) {
        this.coinChanged()
      }
    } catch (error) {
      console.error("加载币种失败:", error)
      this.element.querySelector('#error-message').textContent = '无法加载币种，请重试'
    }
  }

  async coinChanged() {
    const userExchangeId = this.exchangeSelectTarget.value
    const coinId = this.coinSelectTarget.value
    this.clearCoinInfo()

    if (!userExchangeId || !coinId) {
      return
    }

    try {
      this.balanceAmountTarget.textContent = '加载中...'
      this.priceAmountTarget.textContent = '加载中...'
      const response = await fetch(`/trades/coin_info/${userExchangeId}/${coinId}`)
      if (!response.ok) throw new Error(`HTTP error ${response.status}`)
      const data = await response.json()

      if (data.error) {
        throw new Error(data.error)
      }

      this.balanceAmountTarget.textContent = `${data.balance}`
      this.priceAmountTarget.textContent = `${data.price} USDT`
      this.priceTarget.value = data.price
      this.updateTotal()
    } catch (error) {
      console.error("加载币种信息失败:", error)
      this.balanceAmountTarget.textContent = '错误'
      this.priceAmountTarget.textContent = '错误'
      const modal = new bootstrap.Modal(document.getElementById('errorModal'))
      document.getElementById('modal-error-message').textContent = error.message || '无法加载币种信息，请重试'
      modal.show()
    }
  }

  updateTotal() {
    const price = parseFloat(this.priceTarget.value) || 0
    const quantity = parseFloat(this.quantityTarget.value) || 0
    const total = (price * quantity).toFixed(2)
    this.totalAmountTarget.textContent = total
    this.orderSummaryTarget.style.display = total > 0 ? 'block' : 'none'
  }

  clearCoinInfo() {
    this.balanceAmountTarget.textContent = ''
    this.priceAmountTarget.textContent = ''
  }
}