import 'bootstrap/dist/css/bootstrap.min.css';
 import React from 'react';
 import ReactDom, { BrowserRouter } from 'react-router-dom';
 import './index.css';
 import App from './App';

 ReactDom.render(
    <React.StrictMode>
        <BrowserRouter>
        <App/>
        </BrowserRouter>
    </React.StrictMode>
 )
