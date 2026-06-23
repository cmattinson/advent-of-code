from hashlib import md5


def solve(key: str) -> tuple[int, int]:
    key_bytes = key.encode()
    prefix5 = None
    candidate = 1
    while True:
        h = md5(key_bytes + str(candidate).encode()).digest()
        if h[0] == 0 and h[1] == 0:
            if prefix5 is None and h[2] >> 4 == 0:
                prefix5 = candidate
            if h[2] == 0:
                assert prefix5 is not None
                return (prefix5, candidate)
        candidate += 1
