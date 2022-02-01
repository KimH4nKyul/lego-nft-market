import React from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { Home, World, About, Create } from './pages';
import { Intro, Menu } from './components';

function App() {
  console.log("App");
  return (
    <div>
      <div>
        <Menu />
      </div>
      <div>
        <BrowserRouter>
          <Routes>
            <Route exact path="/" element={<Home />} />
            <Route path="/world" element={<World />} />
            <Route path="/create" element={<Create />} />
            <Route path="/about" element={<About />} />
          </Routes>
        </BrowserRouter>
      </div>
      <div className='content_max_size_mm'>
        <Intro />
      </div>
    </div >
  );
}

export default App;
