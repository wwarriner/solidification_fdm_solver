classdef SolidificationTime < handle
    
    properties ( GetAccess = public, SetAccess = private )
        
        values
        
    end
    
    
    methods ( Access = public )
        
        function obj = SolidificationTime( shape )
            
            obj.values = zeros( shape );
            
        end
        
        
        function update( ...
                obj, ...
                fdm_mesh, ...
                pp, ...
                u_prev, ...
                u_next, ...
                stop_fraction, ...
                simulation_time, ...
                simulation_time_step ...
                )
            
            assert( 0 < stop_fraction );
            assert( stop_fraction <= 1 );
            
            fs_next = pp.lookup_values( Material.FS, u_next );
            prev_time = simulation_time - simulation_time_step;
            
            if stop_fraction == 0.0
                stop_temperature = pp.get_liquidus_temperature();
            elseif stop_fraction == 1.0
                stop_temperature = pp.get_solidus_temperature();
            else
                stop_temperature = pp.get_feeding_effectivity_temperature();
            end
            
            sol_times = ( stop_temperature - u_prev ) ./ ( u_next - u_prev ) .* ...
                ( simulation_time - prev_time ) + prev_time;
            updates = fdm_mesh == melt_id & ...
                fs_next >= stop_fraction & ...
                obj.values == 0;
            obj.values( updates ) = sol_times( updates );
            
        end
        
        
        function finished = is_finished( obj, fdm_mesh, melt_id )
            
            finished = all( fdm_mesh ~= melt_id | obj.values > 0 );
            
        end
        
        
        function time = get_final_time( obj )
            
            time = max( obj.values( : ) );
            
        end
        
    end
    
end

