se array::ArrayTrait;

struct Imge {
    width: u64,
    height: u64,
}
u
fn rotate(arr: @Array<u128>, width: u32) -> u252 { 
  //let mut new_pixels = vec![0_u8; w * h * 4];
    let mut new_x;
    let mut new_y;
    let mut new_idx: usize;
    let mut current_idx: usize;
    let height =arr.len()/width;
    let mut i=0;
    let mut j=0;
    let mut rotatedArray = ArrayTrait::new();
     loop {
        if i==width
          {
            i=0;
            break;
          }
        
        loop {
            if j==width 
            {
              j=0;
              break;
            }
            rotatedArray[j * height + (height - 1 - i)] = originalArray[i * width + j];
            j++;
        }
        i++;
    }


}