
import React from 'react';
import { createRoot } from 'react-dom/client';

import Invites from './invites';

const root_div = document.getElementById('invites-main');
if (root_div) {
  const root = createRoot(root_div);
  root.render(<Invites />);
}
