function physical_properties = generate_constant_test_properties( ambient_id, mold_id, melt_id )

physical_properties = generate_constant_non_melt( ambient_id, mold_id, melt_id );
 
melt = MeltMaterial( melt_id );
melt.set( RhoProperty( 2700 ) ); % kg / m ^ 3
melt.set( CpProperty( 900 ) ); % J / kg * K
melt.set( KProperty( 200 ) ); % W / m * K
melt_fs_val = [ 1.0 0.0 ]; % ratio
melt_fs_temp = [ 659.9 660.1 ]; % C
melt.set( FsProperty( melt_fs_temp, melt_fs_val ) );
melt.set_feeding_effectivity( 0.5 ); % ratio
melt.set_initial_temperature( 700 ); % C

physical_properties.add_melt_material( melt );

end
