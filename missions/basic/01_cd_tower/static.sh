#!/usr/bin/env sh
tower="$(eval_gettext "\$GSH_HOME/Castle/Main_tower/First_floor/Second_floor/Top_of_the_tower")"
mkdir -p "$tower"

# Create the cider_press.py script in the top of the tower
cat > "$tower/cider_press.py" <<'PYTHON_SCRIPT'
#!/usr/bin/env python3
"""Make cider press that creates keg_of_cider.txt"""

def main():
    """Create a keg of cider by writing to a file."""
    with open("keg_of_cider.txt", "w") as f:
        f.write("Lots of NA cider!!!")
    print("✓ A fresh keg of cider has been created!")

if __name__ == "__main__":
    main()
PYTHON_SCRIPT

chmod +x "$tower/cider_press.py"
