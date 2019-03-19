function addpath_recurse()
    delete(py.sys.path);
    root_path = 'C:\Users\Maydor\Desktop\CyKITv2-masterMIO_CLEAN_PYTHON_371\CyKITv2-masterMIO\Python\';
    insert(py.sys.path,int32(0),root_path)
    insert(py.sys.path,int32(0),'');
    insert(py.sys.path,int32(0),[root_path 'cyUSB']);
end 
