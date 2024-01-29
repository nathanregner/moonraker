import os
import shutil
import tempfile

def move_no_overwrite(src:str,dst:str)->None:
    dst_name, dst_ext = os.path.splitext(dst)

    # try:
    #     os.link(src, dst)
    #     return dst
    # except FileExistsError:
    #     i = 1
    #     while True:
    #         dst = f"{dst_name}({i}){dst_ext}"
    #         try:
    #             os.link(src, dst)
    #             return dst
    #         except FileExistsError:
    #             i += 1
    #         except OSError:
    #             break
    # except OSError:
    #     pass

    i = 1
    while os.path.exists(dst):
        dst = f"{dst_name}({i}){dst_ext}"
        i += 1
    shutil.move(src, dst)
    return dst


# class TestSecureServerStart:
#     def test_rename(self):
with tempfile.TemporaryDirectory() as tmpdir:
    for value in range(0,3):
        with tempfile.NamedTemporaryFile() as f:
            print(move_no_overwrite(f.name, f"{tmpdir}/f.txt"))

with tempfile.TemporaryDirectory(dir='.') as tmpdir:
    for value in range(0,3):
        with tempfile.NamedTemporaryFile() as f:
            print(move_no_overwrite(f.name, f"{tmpdir}/f.txt"))
