
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
