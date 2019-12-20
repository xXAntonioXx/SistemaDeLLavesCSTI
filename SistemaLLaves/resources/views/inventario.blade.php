@extends('layouts.navFoot')
@section('cuerpo')
<div id="app" style="display:flex; justify-content: center;">
  <objetoslist></objetoslist>
</div>
<script src="{{asset('js/app.js')}}"></script>
@stop