// Test runner eseguito alla creazione della room
var all_results = [];

// Esegui test_ueVector2
if (is_undefined(test__UeVector2) == false) {
    var res = test__UeVector2();
    for (var i = 0; i < array_length(res); i++) {
        array_push(all_results, res[i]);
        var entry = res[i];
        if (entry.ok) {
            show_debug_message("[PASS] " + entry.name);
        } else {
            show_debug_message("[FAIL] " + entry.name + " expected:" + string(entry.b) + " got:" + string(entry.a));
        }
    }
} else {
    show_debug_message("Test script test__UeVector2 non trovato");
}

// Riepilogo
var passed = 0;
for (var i = 0; i < array_length(all_results); i++) if (all_results[i].ok) passed++;
var total = array_length(all_results);
show_debug_message("--- Test Summary ---");
show_debug_message("Passed: " + string(passed) + " / " + string(total));