class BinarySearch {
  static int leftPointer = 0;
  static int rightPointer = 0;

  int binarySearch(List array, int target, int left, int right) {
    if (left > right) {
      return -1;
    }
    int mid = (left + right) ~/ 2;
    int match = array[mid];

    if (target == match) {
      leftPointer = left;
      rightPointer = right;
      print('found at index: $mid');

      return mid;
    } else if (target < match) {
      rightPointer = mid - 1;
      return binarySearch(array, target, left, mid - 1);
    } else {
      leftPointer = mid + 1;
      return binarySearch(array, target, mid + 1, right);
    }
  }
}
