path=$1
files=$(ls $path)
for filename in $files
do
file=$(echo $filename | cut -d . -f1)
echo $file
gcc -S src/$file.c -o $2/$file$3.s $3
clang -S src/$file.c -o $2/$file-clang$3.s $3
clang -emit-llvm -S src/$file.c -o $2/$file$3.ll $3
done
