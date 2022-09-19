# Laboratorio VXLAN & EVPN LACNOG

## How to deploy


### Source code

```bash
# Clone repo
git clone https://github.com/LACNOG/doc-labs-vxlanevpn.git
cd doc-labs-vxlanevpn

# Create local development environment
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Run the testing server
mkdocs serve
```

Now you can connect to http://localhost:8000 from any web browser. All changes you make to the `docs/` folder will be automatically refreshed in your browser.

### Docker

```bash
docker run --name doc_vxlan_evpn_lab_lacnog -d --rm -p 8000:80 reg.dc.celp.red/lacnog/doc-lab-vxlan-evpn:latest
```

Now you can connect to http://localhost:8000 from any web browser.
