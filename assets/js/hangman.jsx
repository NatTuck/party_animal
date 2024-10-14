
import React, { useState, useEffect } from 'react';
import { createRoot } from 'react-dom/client';

import { Button, TextInput } from 'flowbite-react';

import socket from './user_socket';

let channel = socket.channel("game:lobby", {})
const root_div = document.getElementById('hangman-main');
if (root_div) {
  const root = createRoot(root_div);
  root.render(<Game />);
}

function Game(props) {
  const [view, setView] = useState({lives: 5, skeleton: "blank", guesses: "blank"});

  useEffect(() => {
    channel.join()
      .receive("ok", resp => {
        let {view} = resp;
        console.log("Joined successfully", resp);
        channel.push("get_view", {});
        setView(view);
      })
      .receive("error", resp => { console.log("Unable to join", resp) });
  }, []);

  function doGuess(ev) {
    ev.preventDefault();
    let letter = document.getElementById('guessField').value;
    channel.push("guess", {letter})
      .receive("ok", ({view}) => setView(view));
  }

  let {lives, skeleton, guesses} = view;

  return (
    <div>
      <p>Lives left: {lives}</p>
      <p>Skeleton: {skeleton}</p>
      <p>Guesses: {guesses}</p>
      <div><TextInput id="guessField" /><Button onClick={doGuess}>Guess</Button></div>
    </div>
  );
}

