@extends('layouts.navFoot')
@section('cuerpo')
    <div id="app" class="container-wrapper">
      <registro></registro>
    </div>
    <script src="{{asset('js/app.js')}}"></script>
    
  <script>
      const ipad = window.matchMedia('screen and (max-width: 744px)');
      const menu = document.querySelector('.menu');
      const burgerButton = document.querySelector('#burger-menu');
      ipad.addListener(validation);
      function validation(event){
        if(event.matches){
          burgerButton.addEventListener('click', hideShow);
        } else {
          burgerButton.removeEventListener('click', hideShow);
        }
      }
      validation(ipad);
      function hideShow(){
        if(menu.classList.contains('is-active')){
          menu.classList.remove('is-active');
        }else {
          menu.classList.add('is-active');
        }
      }
    </script>
@stop