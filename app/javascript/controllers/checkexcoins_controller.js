import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["coin"];

  connect() {
    console.log("Checkexcoins controller connected");
    console.log("Found coin targets:", this.coinTargets.length);
  }

  fetchCoins(event) {
    const exchangeId = event.target.value;
    console.log("Selected exchange ID:", exchangeId);

    // 重置所有复选框
    this.coinTargets.forEach(checkbox => {
      checkbox.disabled = false;
      checkbox.checked = false;
    });

    // 如果未选择交易所，退出
    if (!exchangeId) {
      console.log("No exchange selected");
      return;
    }

    // AJAX 请求已绑定的币种
    fetch(`/exchange_coins/coins_for_exchange?exchange_id=${exchangeId}`, {
      headers: { Accept: "application/json" }
    })
      .then(response => {
        if (!response.ok) throw new Error(`HTTP error: ${response.status}`);
        return response.json();
      })
      .then(data => {
        console.log("Received coin_ids:", data.coin_ids);
        this.coinTargets.forEach(checkbox => {
          const coinId = parseInt(checkbox.dataset.coinId);
          if (data.coin_ids.includes(coinId)) {
            checkbox.disabled = true;
            console.log(`Disabled coin ID ${coinId}`);
          }
        });
      })
      .catch(error => {
        console.error("Error fetching coins:", error);
        alert("无法加载币种信息，请稍后重试");
      });
  }
}