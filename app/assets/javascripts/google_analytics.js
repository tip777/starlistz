window.onload = function() {
  if (typeof ga === 'function') {
    ga('set', 'location', location.pathname);
    ga('send', 'pageview');
    // console.log('analytics 送ってるよー');
  }
}