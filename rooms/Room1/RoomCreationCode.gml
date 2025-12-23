// ============================================================================
// BENCHMARK: UeVector2 (struct) vs vec2 (array)
// ============================================================================
//show_debug_message("=== BENCHMARK: UeVector2 vs vec2 ===");
//
//var ITERATIONS = 100000;
//var start_time, end_time;
//var i;
//
//// --- BENCHMARK 1: Creation ---
//show_debug_message("\n[1] CREATION (" + string(ITERATIONS) + " iterations)");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var v = new UeVector2(i, i * 2);
//}
//end_time = get_timer();
//var ue_create_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_create_time) + " ms");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var v = vec2_create(i, i * 2);
//}
//end_time = get_timer();
//var vec2_create_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_create_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_create_time / vec2_create_time) + "x");
//
//// --- BENCHMARK 2: Add operation ---
//show_debug_message("\n[2] ADD OPERATION (" + string(ITERATIONS) + " iterations)");
//
//var ue_a = new UeVector2(1, 2);
//var ue_b = new UeVector2(3, 4);
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //ue_a.add(ue_b);
//}
//end_time = get_timer();
//var ue_add_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_add_time) + " ms");
//
//var v2_a = vec2_create(1, 2);
//var v2_b = vec2_create(3, 4);
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //vec2_add(v2_a, v2_b);
//}
//end_time = get_timer();
//var vec2_add_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_add_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_add_time / vec2_add_time) + "x");
//
//// --- BENCHMARK 3: Normalize ---
//show_debug_message("\n[3] NORMALIZE (" + string(ITERATIONS) + " iterations)");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var ue_v = new UeVector2(3, 4);
    //ue_v.normalize();
//}
//end_time = get_timer();
//var ue_norm_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_norm_time) + " ms");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var v2_v = vec2_create(3, 4);
    //vec2_normalize(v2_v);
//}
//end_time = get_timer();
//var vec2_norm_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_norm_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_norm_time / vec2_norm_time) + "x");
//
//// --- BENCHMARK 4: Dot product ---
//show_debug_message("\n[4] DOT PRODUCT (" + string(ITERATIONS) + " iterations)");
//
//var ue_d1 = new UeVector2(3, 4);
//var ue_d2 = new UeVector2(5, 6);
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var r = ue_d1.dot(ue_d2);
//}
//end_time = get_timer();
//var ue_dot_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_dot_time) + " ms");
//
//var v2_d1 = vec2_create(3, 4);
//var v2_d2 = vec2_create(5, 6);
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var r = vec2_dot(v2_d1, v2_d2);
//}
//end_time = get_timer();
//var vec2_dot_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_dot_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_dot_time / vec2_dot_time) + "x");
//
//// --- BENCHMARK 5: Length ---
//show_debug_message("\n[5] LENGTH (" + string(ITERATIONS) + " iterations)");
//
//var ue_len = new UeVector2(3, 4);
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var r = ue_len.length();
//}
//end_time = get_timer();
//var ue_length_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_length_time) + " ms");
//
//var v2_len = vec2_create(3, 4);
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var r = vec2_length(v2_len);
//}
//end_time = get_timer();
//var vec2_length_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_length_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_length_time / vec2_length_time) + "x");
//
//// --- BENCHMARK 6: Lerp ---
//show_debug_message("\n[6] LERP (" + string(ITERATIONS) + " iterations)");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var ue_l = new UeVector2(0, 0);
    //var ue_t = new UeVector2(10, 10);
    //ue_l.lerp(ue_t, 0.5);
//}
//end_time = get_timer();
//var ue_lerp_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_lerp_time) + " ms");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var v2_l = vec2_create(0, 0);
    //var v2_t = vec2_create(10, 10);
    //vec2_lerp(v2_l, v2_t, 0.5);
//}
//end_time = get_timer();
//var vec2_lerp_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_lerp_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_lerp_time / vec2_lerp_time) + "x");
//
//// --- BENCHMARK 7: Combined operations (real-world scenario) ---
//show_debug_message("\n[7] COMBINED OPS: create + add + normalize + dot (" + string(ITERATIONS) + " iterations)");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var ue_c1 = new UeVector2(i, i * 2);
    //var ue_c2 = new UeVector2(i + 1, i * 2 + 1);
    //ue_c1.add(ue_c2);
    //ue_c1.normalize();
    //var r = ue_c1.dot(ue_c2);
//}
//end_time = get_timer();
//var ue_combined_time = (end_time - start_time) / 1000;
//show_debug_message("  UeVector2: " + string(ue_combined_time) + " ms");
//
//start_time = get_timer();
//for (i = 0; i < ITERATIONS; i++) {
    //var v2_c1 = vec2_create(i, i * 2);
    //var v2_c2 = vec2_create(i + 1, i * 2 + 1);
    //vec2_add(v2_c1, v2_c2);
    //vec2_normalize(v2_c1);
    //var r = vec2_dot(v2_c1, v2_c2);
//}
//end_time = get_timer();
//var vec2_combined_time = (end_time - start_time) / 1000;
//show_debug_message("  vec2:      " + string(vec2_combined_time) + " ms");
//show_debug_message("  Speedup:   " + string(ue_combined_time / vec2_combined_time) + "x");
//
//// --- SUMMARY ---
//show_debug_message("\n=== BENCHMARK SUMMARY ===");
//var total_ue = ue_create_time + ue_add_time + ue_norm_time + ue_dot_time + ue_length_time + ue_lerp_time + ue_combined_time;
//var total_vec2 = vec2_create_time + vec2_add_time + vec2_norm_time + vec2_dot_time + vec2_length_time + vec2_lerp_time + vec2_combined_time;
//show_debug_message("Total UeVector2: " + string(total_ue) + " ms");
//show_debug_message("Total vec2:      " + string(total_vec2) + " ms");
//show_debug_message("Overall Speedup: " + string(total_ue / total_vec2) + "x");
//show_debug_message("=============================\n");
