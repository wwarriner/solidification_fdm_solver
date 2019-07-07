classdef Interfaces < handle
    
    properties ( GetAccess = public, SetAccess = private )
        count(1,1) uint64 {mustBePositive} = 1
        element_ids(:,:) uint64 {mustBePositive} = 1
        areas(:,1) double {mustBeReal,mustBeFinite,mustBePositive} = 1
        distances(:,:) double {mustBeReal,mustBeFinite,mustBePositive} = 1
        boundary_ids(:,1) uint64 {mustBeNonnegative} = 0
    end
    
    
    methods ( Access = public )
        
        function obj = Interfaces( ...
                elements, ...
                element_ids, ...
                areas, ...
                distances ...
                )
            assert( size( element_ids, 2 ) == obj.COLUMN_COUNT );
            assert( numel( areas ) == size( element_ids, 1 ) );
            assert( all( size( distances ) == size( element_ids ) ) );
            
            obj.elements = elements;
            obj.count = size( element_ids, 1 );
            obj.element_ids = element_ids;
            obj.areas = areas;
            obj.distances = distances;
            obj.boundary_ids = zeros( obj.count, 1 );
        end
        
        function assign_uniform_id( obj, id )
            obj.assign_id( id, 1 : obj.count );
        end
        
        function assign_id( obj, id, interface_ids )
            assert( isscalar( id ) );
            assert( isnumeric( id ) );
            assert( 0 < id );
            
            assert( isvector( interface_ids ) );
            assert( isnumeric( interface_ids ) );
            assert( all( interface_ids <= obj.count ) );
            assert( all( 0 < interface_ids ) );
            
            obj.boundary_ids( interface_ids ) = id;
        end
        
        function count = get_id_count( obj )
            count = numel( obj.get_unique_ids() );
        end
        
        function ids = get_unique_ids( obj )
            ids = unique( obj.boundary_ids );
        end
        
    end
    
    
    properties ( Access = protected )
        elements mesh.utils.Elements
    end
    
    
    properties ( Abstract, Access = protected, Constant )
        COLUMN_COUNT
    end
    
end

