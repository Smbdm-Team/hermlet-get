# SMBDM Agent: one-line setup

SMBDM Agent lets you use **your own Hermes Agent** from your iPhone, iPad, Android phone or another
computer. Hermes keeps running on your Mac or Windows PC; your devices reach it through
**Tailscale**, the company's private network. Nobody else can see it, and it always asks for your
password.

You don't need a GitHub account. Nothing secret goes in the line you paste.

- [Mac](#mac)
- [Windows PC](#windows-pc)
- [Add it to your phone](#add-it-to-your-phone)
- [Update or remove](#update-or-remove)
- [If something goes wrong](#if-something-goes-wrong)

## Before you start

On the computer that runs Hermes:

- **Hermes Agent** is installed and works.
- **Tailscale** is installed, signed in with your **work account**, and shows **Connected**.

On your phone: **Tailscale**, signed in with the same account.

## Mac

1. If you use **Hermes Desktop**, quit it first (press **⌘Q** in Desktop).
2. Open **Terminal** (press **⌘-Space**, type **Terminal**, press **Return**).
3. Paste this line and press **Return**:

   ```sh
   curl -fsSL https://smbdm-team.github.io/smbdm-agent-get/install | bash
   ```

4. Answer the two questions:
   - **Username**: press **Return** to use your Mac's name, or type another one.
   - **Password**: at least 12 characters, typed twice. Nothing appears while you type; that's
     normal. Keep it somewhere safe (a password manager is best).
5. Wait for **"SMBDM Agent is ready on this Mac."** (a minute or two). It shows **your link**, e.g.
   `https://your-mac.your-company.ts.net/agent/`, and saves it in `~/smbdm-agent/your-link.txt`.

### If you use Hermes Desktop

The setup makes Desktop open your chats through the same Hermes as SMBDM Agent, so a chat is never
*"open in another Hermes window"*.

The **first time** you open Desktop afterwards, it says you're **not signed in** ("Remote gateway
sign-in required" or "Hermes couldn't start"). Do this once:

1. Click **Sign out & sign in** (or **Gateway settings**, then **Sign in**).
2. Enter your SMBDM Agent **username** and **password**.
3. Click **Save and reconnect** if it asks.

Desktop stays signed in after that. If Desktop was open during the setup, the setup leaves it
alone and says so: quit Desktop, paste the line again, then open Desktop.

**To put Desktop back the way it was:**

- **Quick (keeps SMBDM Agent):** in Hermes Desktop, switch the gateway at the bottom of the chats
  list to **This device**, then right-click the home icon and choose **Set as default**. A chat open
  in both Desktop and SMBDM Agent may then say *"open in another Hermes window"* again.
- **Full undo:** [remove SMBDM Agent](#update-or-remove). That puts Desktop's settings back exactly
  as they were before the setup (it kept a backup).

## Windows PC

1. Open **PowerShell** (press the **Windows key**, type **PowerShell**, press **Enter**). A normal
   window is right; you don't need "Run as administrator".
2. Paste this line and press **Enter**:

   ```powershell
   irm https://smbdm-team.github.io/smbdm-agent-get/install.ps1 | iex
   ```

3. Answer the two questions:
   - **Username**: press **Enter** to use your Windows name, or type another one.
   - **Password**: at least 12 characters, typed twice.
4. Wait for **"SMBDM Agent is ready on this PC."** The first time it can take up to two minutes
   while Tailscale gets the PC's secure address ready.

Your link is saved in `C:\Users\<you>\smbdm-agent\your-link.txt`. SMBDM Agent starts by itself,
without a window, every time you sign in to Windows. Keep the PC on and signed in.

## Add it to your phone

1. Make sure **Tailscale** is on and connected on the phone.
2. Open your link:
   - **iPhone / iPad**: in **Safari**, tap **Share → Add to Home Screen → Add**.
   - **Android**: in **Chrome**, tap **Install app** (or **⋮ → Install app**).
   - **Another computer**: in Chrome or Edge, click the **install icon** in the address bar.
3. Open SMBDM Agent from the home screen and sign in with your username and password.
4. For alerts when the app is closed (a reply is ready, Hermes needs you, a job finished): in the
   app, open **Settings → Notifications** and turn on **Push notifications**. On iPhone and iPad
   this needs iOS 16.4+ and the app opened from the Home Screen.

Your link only works on devices signed in to Tailscale, and only while the Hermes computer is on
and logged in.

## Update or remove

**Update:** paste the same line again. Your sign-in, link and chats stay the same, and it repairs
anything that's missing. Then close and reopen the app on your phone.

**Remove:**

| Computer | Paste this, then type **yes** |
| --- | --- |
| Mac (quit Hermes Desktop first) | `curl -fsSL https://smbdm-team.github.io/smbdm-agent-get/install \| bash -s -- --uninstall` |
| Windows (PowerShell) | `iex "& { $(irm https://smbdm-team.github.io/smbdm-agent-get/install.ps1) } --uninstall"` |

It removes SMBDM Agent, its push notifications plugin, the sign-in it set up and its Tailscale
sharing, and puts back anything it replaced, including Hermes Desktop's settings (from the backup
it made during setup). Hermes Agent and
your chats are not touched. Then delete the icon from your phone.

## If something goes wrong

The window ends with **"Setup stopped (code N)"**:

| Code | What it means | What to do |
| --- | --- | --- |
| 1 | Your sign-in wasn't saved: the passwords didn't match or were too short. | Paste the line again; type the same password twice, at least 12 characters. |
| 2 | Hermes or the app didn't start. The message names a log file. | Restart the computer and paste the line again. If it happens again, send that log file to the tech team. |
| 3 | Hermes Agent or Tailscale isn't installed (or this isn't a Mac / Windows PC). | Install the missing one, then paste the line again. |
| 4 | Tailscale is off or not signed in. | Open Tailscale, sign in with your work account, wait for **Connected**, then paste the line again. |
| 5 | Something else is in the way (another program uses the same port, or Tailscale already shares something). When removing: Hermes Desktop is open. | Removing: quit Hermes Desktop and try again. Otherwise restart and try again; if it still says 5, ask the tech team. |
| 6 | The safety check failed, so nothing was shared. | Paste the line again. If it still says 6, send the lines in the window to the tech team. |
| 7 | You chose update or remove, but SMBDM Agent isn't set up here. | Install it first. |
| 10 | Mac only: the line wasn't pasted into Terminal (it needs a keyboard for the password). | Open the **Terminal** app and paste it there. |
| 11 | The download didn't work. | Check the internet connection and paste the line again. |
| 12 | The download wasn't the published SMBDM Agent, so it wasn't run. | Paste the line again. If it says 12 again, tell the tech team. |

Other problems:

- **The link doesn't open on my phone**: Tailscale must be on on the phone *and* the computer,
  and the computer awake and logged in.
- **Hermes Desktop says "not signed in"**: sign it in once (see [If you use Hermes Desktop](#if-you-use-hermes-desktop)).
- **No alerts when the app is closed**: check **Push notifications** is on in the app's Settings.
- **I forgot my password**: remove it, then install it again and choose a new one.
- **The app on my phone looks old**: close it completely and open it again.

Questions: ask the SMBDM tech team.
