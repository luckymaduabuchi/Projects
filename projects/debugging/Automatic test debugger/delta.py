import subprocess
import os
import shutil

shutil.copy("file1v1.java", "file1v1_backup.java")
all_diffs = []  # List to accumulate all diffs
step_counter = 0  # Global step counter


def reset_code():
    """Reset file1v1.java to its original state by copying from the backup."""
    if os.path.isfile("file1v1.java"):
        os.remove("file1v1.java")
    shutil.copy("file1v1_backup.java", "file1v1.java")


def apply_patch(patch_file_path):
    """Apply a given patch using the patch command, print the diff, and return whether it was successful."""
    shutil.copy("file1v1.java", "file1v1_temp.java")

    result = subprocess.run(["patch", "file1v1.java", patch_file_path],
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    diff_result = subprocess.run(["diff", "-u", "file1v1_temp.java", "file1v1.java"],
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    diff_output = diff_result.stdout.decode()
    relevant_diffs = [line for line in diff_output.split('\n') if line.startswith('@@') and line.endswith('@@')]
    all_diffs.extend(relevant_diffs)

    os.remove("file1v1_temp.java")

    return result.returncode == 0


def accumulate_diffs():
    for individual_patch in patches:
        reset_code()
        apply_patch(individual_patch)


def run_tests():
    compile_result = subprocess.run(["javac", "file1v1.java"],
                                    stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if compile_result.returncode != 0:
        return False

    move_result = subprocess.run(["mv", "file1v1.class", "test_case/"],
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if move_result.returncode != 0:
        return False

    test_result = subprocess.run(["java", "test_case.file1v1", "5", "0", "division"],
                                 stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    return test_result.returncode == 0


def test(change_set):
    reset_code()
    for single_patch in change_set:
        if not apply_patch(single_patch):
            return False
    return run_tests()


def print_step(current_step, c, r, result):
    patch_indices = ' '.join([str(patches.index(p)) for p in c + r])
    print(f"Step {current_step}: c_{current_step}: {patch_indices} {result}")


def dd2(c, r):
    global step_counter  # Declare to modify global variable
    n = len(c)

    if n == 1:
        step_counter += 1
        test_result = test(c + r)
        result = "PASS" if test_result else "FAIL"
        print_step(step_counter, c, r, result)
        return c if not test_result else []

    c1 = c[:n // 2]
    c2 = c[n // 2:]

    step_counter += 1
    test_result1 = test(c1 + r)
    result1 = "PASS" if test_result1 else "FAIL"
    print_step(step_counter, c1, r, result1)
    if not test_result1:
        return dd2(c1, r)

    step_counter += 1
    test_result2 = test(c2 + r)
    result2 = "PASS" if test_result2 else "FAIL"
    print_step(step_counter, c2, r, result2)
    if not test_result2:
        return dd2(c2, r)

    r1_results = dd2(c1, c2 + r)
    r2_results = dd2(c2, c1 + r)

    return r1_results + r2_results


def dd(c):
    return dd2(c, [])


patches = [
    "patch/file1v1.java.000.patch",
    "patch/file1v1.java.001.patch",
    "patch/file1v1.java.002.patch",
    "patch/file1v1.java.003.patch",
    "patch/file1v1.java.004.patch",
    "patch/file1v1.java.005.patch",
    "patch/file1v1.java.006.patch",
    "patch/file1v1.java.007.patch",
    "patch/file1v1.java.008.patch",
    "patch/file1v1.java.009.patch"
]

print("Delta-debugging Project")
print(f"# of Total Change sets is = {len(patches)}")
accumulate_diffs()
for diff in all_diffs:
    print(diff)
failure_inducing_patches = dd(patches)
print("Failure-inducing patch paths:")
for patch_path in failure_inducing_patches:
    print(patch_path)

print("Changes where bugs occurred:", [patches.index(p) + 1 for p in failure_inducing_patches])
