%% DEFINITIONS
ambient_id = 0;
mold_id = 1;
melt_id = 2;
element_size_in_mm = 100; % mm
simulation_time_step_in_s = 100; % s

%% TEST MESH GENERATION
side_length = 50;
shape = [ ...
    side_length ...
    2 * side_length ...
    side_length / 2 ...
    ];
[ fdm_mesh, center ] = generate_test_mesh( mold_id, melt_id, shape );

%% TEST PROPERTY GENERATION
pp = generate_constant_test_properties( ambient_id, mold_id, melt_id );
pp.set_space_step( element_size_in_mm / 1000 ) % m
pp.set_max_length( shape ); % count
pp.prepare_for_solver();

%% SOLVER
mg = MatrixGenerator( fdm_mesh, pp );
solver = Solver( fdm_mesh, pp, mg );
solver.turn_printing_on();
solver.turn_live_plotting_on();
solver.solve( simulation_time_step_in_s, melt_id );

