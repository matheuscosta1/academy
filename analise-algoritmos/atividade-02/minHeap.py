# Function to check if the given list represents min-heap or not
def checkMinHeap(A, i):
 
    # if `i` is a leaf node, return true as every leaf node is a heap
    if 2*i + 2 > len(A):
        return True
 
    # if `i` is an internal node
 
    # recursively check if the left child is a heap
    left = (A[i] <= A[2*i + 1]) and checkMinHeap(A, 2*i + 1)
 
    # recursively check if the right child is a heap (to avoid the list index out
    # of bounds, first check if the right child exists or not)
    right = (2*i + 2 == len(A)) or (A[i] <= A[2*i + 2]
                                    and checkMinHeap(A, 2*i + 2))
 
    # return true if both left and right child are heaps
    return left and right
 
 
if __name__ == '__main__':
 
    A = [9, 6, 3, 4, 5, -1, -3, 1, 0, -7]
 
    # start with index 0 (the root of the heap)
    index = 0
 
    if checkMinHeap(A, index):
        print("The given list is a min-heap")
    else:
        print("The given list is not a min-heap")
