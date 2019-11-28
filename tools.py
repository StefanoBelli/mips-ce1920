def little2big4(dw):
    return ((dw & 0x000000FF) << 24) | ((dw & 0x0000FF00) << 16) | ((dw & 0x00FF0000) << 8) | ((dw & 0xFF000000) >> 24)

def big2little4(dw):
    return ((dw & 0xFF000000) >> 24) | ((dw & 0x00FF0000) >> 16) | ((dw & 0x0000FF00) >> 8) | ((dw & 0x000000FF) << 24)

def j(pc, imm):
    return (pc + 4) & 0xF0000000 | (imm << 2)

def b(pc, imm):
    return pc + 4 + (imm << 2)