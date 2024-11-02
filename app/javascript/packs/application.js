document.addEventListener("DOMContentLoaded", function () {
  const stockImages = document.querySelectorAll('.stock-image');

  stockImages.forEach(image => {
    image.addEventListener('click', function () {
      if (this.style.transform === 'scale(1.2)') {
        this.style.transform = 'scale(1)'; // 元のサイズに戻す
      } else {
        this.style.transform = 'scale(1.2)'; // 画像を少し大きくする
      }
    });
  });
});
