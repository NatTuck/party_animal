import React, { useState, useEffect } from 'react';
import { Select, Label, Button, Card, TextInput } from 'flowbite-react';

import { list_invites, create_invite } from './api';

export default function Invites(props) {
  const [invites, setInvites] = useState([]);

  function load_invites() {
    list_invites().then((xs) => setInvites(xs));
  }

  useEffect(load_invites, []);

  console.log(invites);
  
  let invite_items = invites.map((item, ii) => (
    <li key={ii}>
      Invite #{ii}, Ev: { item.event.name }, User: { item.user.email }
    </li>
  ));

  let { events, users } = window.invite_form_data;

  let event_options = events.map((item) => (
    <option value={item.id} key={item.id}>
      { item.name }
    </option>
  ));

  let user_options = users.map((item) => (
    <option value={item.id} key={item.id}>
      { item.email }
    </option>
  ));

  function on_submit(ev) {
    ev.preventDefault();
    let event_id = document.getElementById('event_id').value;
    let user_id = document.getElementById('user_id').value;

    create_invite({event_id, user_id}).then((resp) => {
      console.log("created invite", resp);
      load_invites();
      // Alternatively, we could just add the new invite to the list
      // without another request.
    });
  }

  return (
    <div className="flex items-center justify-center">
      <Card className="max-w-small">
        <ul>
          { invite_items }
        </ul>
      </Card>

      <Card className="max-w-small">
        <p>New Invite</p>
        <form onSubmit={on_submit}>
          <div>
            <Label htmlFor="event_id" value="Event" />
            <Select id="event_id" required>
              { event_options }
            </Select>
          </div>
          <div>
            <Label htmlFor="user_id" value="User" />
            <Select id="user_id" required>
              { user_options }
            </Select>
          </div>
          <div>
            <Button onClick={on_submit}>Create Invite</Button>
          </div>
        </form>
      </Card>
    </div>
  );
}
