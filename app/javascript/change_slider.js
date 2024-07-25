document.addEventListener("turbo:load", function() {
  const slider = document.querySelector('#range_slider');
  const output = document.querySelector('#slider_value');

  slider.addEventListener('input', () =>{
    output.textContent = slider.value;
  });
});
