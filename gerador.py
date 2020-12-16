x=0
while x < 24*30:
    print("\tli t0, 0 #estado")
    print(f"\tsw t0, {x}(a5)")
    print("\tli t0, 0 #alvo")
    print(f"\tsw t0, {x+4}(a5)")
    print("\tli t0, 0 #framehit")
    print(f"\tsw t0, {x+8}(a5)")
    print("\tli t0, 0 #x0")
    print(f"\tsw t0, {x+12}(a5)")
    print("\tli t0, 0 #xf")
    print(f"\tsw t0, {x+16}(a5)\n")
    x+=24
