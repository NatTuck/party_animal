
const base = "/ajax/invites";

export async function list_invites() {
  let resp = await fetch(base, {
    headers: {
      'Accept': 'application/json',
    }
  });
  let decoded = await resp.json();
  return decoded.data;
}

export async function create_invite(attrs) {
  let resp = await fetch(base, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'x-csrf-token': document.querySelector('meta[name="csrf-token"]').content,
    },
    body: JSON.stringify({invite: attrs}),
  });
  let decoded = await resp.json();
  return decoded.data;
}
