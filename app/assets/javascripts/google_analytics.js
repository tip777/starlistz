window.onload = function() {
  console.log('onload は動いてる');
  if (typeof ga === 'function') {
    ga('set', 'location', location.pathname);
    ga('send', 'pageview');
    console.log('analytics 送ってるよー');
  }
}