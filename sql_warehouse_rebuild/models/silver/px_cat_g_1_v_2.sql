SELECT id, cat, subcat, maintenance FROM 
{{ ref ('px_cat_g_1_v_2_bronze') }};