- name: Build package
  run: |
    cd VulnScanX  # Move into the correct directory
    python setup.py sdist bdist_wheel