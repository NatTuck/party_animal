import React, { useState, useEffect } from 'react';
import { Button, Card, TextInput } from 'flowbite-react';

import { list_invites } from './api';

export default function Invites(props) {
  const [invites, setInvites] = useState([]);

  useEffect(() => {
    list_invites().then((xs) => setInvites(xs));
  }, []);

  console.log(invites);
  
  let invite_items = invites.map((item, ii) => (
    <li key={ii}>
      { item.event.name }
    </li>
  ));
  
  return (
    <div className="flex items-center justify-center">
      <Card className="max-w-small">
        <ul>
          { invite_items }
        </ul>
      </Card>

      <Card className="max-w-small">
        <p>New Invite</p>
        <div><TextInput /></div>
        <div><Button>Create Invite</Button></div>
      </Card>
    </div>
  );
}
