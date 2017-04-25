import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import Root from './Root';
import 'whatwg-fetch';

$(function() {
  ReactDOM.render(
    <Root />,
    document.getElementById('app')
  );
});
