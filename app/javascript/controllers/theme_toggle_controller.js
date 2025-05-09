import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];

  connect() {
    // 初始化：检查 localStorage 中的主题偏好
    const savedTheme = localStorage.getItem("theme");
    if (savedTheme === "dark") {
      document.documentElement.style.filter = "invert(1) hue-rotate(180deg)";
      this.element.innerHTML = '<i class="bi bi-sun-fill"></i>';
    } else {
      document.documentElement.style.filter = "none";
      this.element.innerHTML = '<i class="bi bi-moon-stars-fill"></i>';
    }
  }

  toggle() {
    // 切换主题
    const htmlElement = document.documentElement;
    if (htmlElement.style.filter === "invert(1) hue-rotate(180deg)") {
      htmlElement.style.filter = "none";
      this.element.innerHTML = '<i class="bi bi-moon-stars-fill"></i>';
      localStorage.setItem("theme", "light");
    } else {
      htmlElement.style.filter = "invert(1) hue-rotate(180deg)";
      this.element.innerHTML = '<i class="bi bi-sun-fill"></i>';
      localStorage.setItem("theme", "dark");
    }
  }
}