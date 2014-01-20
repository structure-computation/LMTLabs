#pragma inc_path /home/leclerc/dic
#include <correlation/DicCPU.h>
#include <mesh/read_msh.h>
#include <mesh/meshcaracstd.h>

struct DisplayJs {
    template<class TE> void operator()( const TE &e, std::ostream &f ) const {
        f << "mesh.lines.push( [ old_nb_nodes + " << e.nodes[ 0 ]->number << ", old_nb_nodes + " << e.nodes[ 1 ]->number << " ] );\n";
        
    }
};

int main() {
    const int dim = 3;
//    typedef DicCPU<double,dim> TD;
//    typedef TD::TM_exemple TM;
//    typedef TD::Pvec Pvec;
    typedef Mesh<MeshCaracStd<3,2,1> > TM;

    TM m;
    read_msh( m, "conversion/carter.msh" );
    
    // display( m );
    std::ofstream f( "carter.js" );
    f << "var old_nb_nodes = mesh.points.length;\n";
    for( int i = 0; i < m.node_list.size(); ++i )
        f << "mesh.add_point( [ " << m.node_list[ i ].pos[ 0 ] << ", " << m.node_list[ i ].pos[ 1 ] << ", " << m.node_list[ i ].pos[ 2 ] << " ] );\n";
    m.update_skin();
    apply( m.sub_mesh( Number<1>() ).elem_list, DisplayJs(), f );
}




