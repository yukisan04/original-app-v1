document.addEventListener('DOMContentLoaded', () => {
  const increaseButtons = document.querySelectorAll('.increase-quantity');
  const sortOptions = document.getElementById('sort-options');

  // ページが読み込まれたときにソートオプションを復元
  const savedSortOption = localStorage.getItem('sortOption') || 'low-stock';
  sortOptions.value = savedSortOption;
  sortStockItems(savedSortOption); // 初期ソートを適用

  increaseButtons.forEach(button => {
    button.addEventListener('click', () => {
      const stockId = button.getAttribute('data-stock-id');
      const roomId = button.getAttribute('data-room-id');
      const change = 1; // 増加する量

      fetch(`/rooms/${roomId}/stocks/${stockId}/increment`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ change })
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error('Network response was not ok.');
      })
      .then(data => {
        if (data.success) {
          // 数量を更新する
          const quantityDisplay = button.parentNode.querySelector('.quantity-display');
          quantityDisplay.textContent = parseInt(quantityDisplay.textContent) + change;

          // ソート状態を再適用
          sortStockItems(sortOptions.value);
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    });
  });
});

document.addEventListener('DOMContentLoaded', function() {
  const searchBox = document.getElementById('search');
  const stockList = document.getElementById('stock-list');
  const stockItems = stockList.getElementsByClassName('stock-item');
  const sortOptions = document.getElementById('sort-options');

  searchBox.addEventListener('input', function() {
    const query = searchBox.value.toLowerCase();
    Array.from(stockItems).forEach(function(item) {
      const productName = item.querySelector('.stock-info strong').textContent.toLowerCase();
      item.style.display = productName.includes(query) ? '' : 'none';
    });
  });

  sortOptions.addEventListener('change', function() {
    const selectedOption = this.value;
    localStorage.setItem('sortOption', selectedOption); // ソートオプションを保存
    sortStockItems(selectedOption);
  });

  // ページが読み込まれたときに在庫を少ない順にソート
  const savedSortOption = localStorage.getItem('sortOption') || 'low-stock';
  sortOptions.value = savedSortOption;
  sortStockItems(savedSortOption);

  function sortStockItems(value) {
    let sortedStocks;

    if (value === 'low-stock') {
      sortedStocks = Array.from(stockItems).sort((a, b) => {
        const quantityA = parseInt(a.querySelector('.quantity-field').value) || 0;
        const quantityB = parseInt(b.querySelector('.quantity-field').value) || 0;
        return quantityA - quantityB;
      });
    } else if (value === 'high-stock') {
      sortedStocks = Array.from(stockItems).sort((a, b) => {
        const quantityA = parseInt(a.querySelector('.quantity-field').value) || 0;
        const quantityB = parseInt(b.querySelector('.quantity-field').value) || 0;
        return quantityB - quantityA;
      });
    } else if (value === 'updated') {
      sortedStocks = Array.from(stockItems).sort((a, b) => {
        const dateA = new Date(a.dataset.updated); // 最後の更新日時
        const dateB = new Date(b.dataset.updated);
        return dateB - dateA; // 更新が新しいものを上に
      });
    }

    stockList.innerHTML = '';
    sortedStocks.forEach(item => {
      stockList.appendChild(item);
    });
  }
});
