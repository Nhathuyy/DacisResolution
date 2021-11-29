// [[block]] struct Matrix {
//     size : vec4<f32>; // batch_size , channel_size , height , width
//     numbers: array<f32>;
// };


// [[group(0), binding(0)]] var<storage, read_write> inputImage : Matrix;


// [[stage(compute), workgroup_size(4, 4, 4)]]
// fn main([[builtin(global_invocation_id)]] global_id : vec3<u32>) {
//     // Guard against out-of-bounds work group sizes.
//     if (global_id.x >= u32(inputImage.size.w) || global_id.y >= u32(inputImage.size.z) || global_id.z >= u32(inputImage.size.y)) {
//         return;
//     }
//     let index = global_id.z * u32(inputImage.size.z) * u32(inputImage.size.w) + global_id.y * u32(inputImage.size.w) + global_id.x;
//     var result = inputImage.numbers[index];
//     if (result < 0.f) {
//         inputImage.numbers[index] = 0.2 * result; 
//     }
    
    
// }
[[block]] struct Matrix {
    numbers: array<f32>;
};

[[block]] struct UBO {
  inputSizes: vec3<u32, 3>; //channel_size , height , width
};


[[group(0), binding(0)]] var<storage, read_write> inputImage : Matrix;
[[group(0), binding(1)]] var<storage, read> ufs : UBO;


[[stage(compute), workgroup_size(4, 4, 4)]]
fn main([[builtin(global_invocation_id)]] global_id : vec3<u32>) {
    // Guard against out-of-bounds work group sizes.
    if (global_id.x >= ufs.z || global_id.y >= ufs.y || global_id.z >= ufs.x) {
        return;
    }
    let index = global_id.z * ufs.y * ufs.z + global_id.y * ufs.z + global_id.x;
    var result = inputImage.numbers[index];
    if (result < 0.f) {
        inputImage.numbers[index] = 0.2 * result; 
    }
    
    
}
