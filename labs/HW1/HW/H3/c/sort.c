#include <stdio.h>
#include <stdlib.h>

void my_sort(int *nums, int n) {
    for(int i = 0; i < n; i++) {
        for(int j = i + 1; j < n; j++) {
            if(nums[i] > nums[j]) {
                int tmp = nums[i];
                nums[i] = nums[j];
                nums[j] = tmp;
            }
        }
    }
}

int main() {
    int n, *nums;

    // input
    scanf("%d", &n);
    nums = (int*)malloc(sizeof(int)*n);
    for(int i = 0; i < n; i++) {
        scanf("%d", nums+i);
    }

    // sort
    my_sort(nums, n);

    // ouput
    printf("%d", nums[0]);
    for(int i = 1; i < n; i++) {
        printf(" %d", nums[i]);
    }
    printf("\n");

}