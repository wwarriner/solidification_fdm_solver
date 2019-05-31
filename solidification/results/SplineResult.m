classdef SplineResult < modeler.super.Result
    
    methods ( Access = public )
        
        function obj = SplineResult( subscripts )
            
            obj.subscripts = subscripts;
            
        end
        
        
        function update( obj, ~, ~, iterator, problem )
            
            times = iterator.get_simulation_times();
            temperature_field = problem.get_temperature();
            obj.time( end + 1 ) = times.get_time( 1 );
            subs = obj.subscripts;
            obj.temperature( end + 1 ) = temperature_field( ...
                subs( 1 ), ...
                subs( 2 ), ...
                subs( 3 ) ...
                );
            
        end
        
        
        function field = get_scalar_field( obj )
            
            assert( false );
            
        end
        
    end
    
    
    properties ( GetAccess = public, SetAccess = private )
        
        subscripts
        time
        temperature
        
    end
    
end

