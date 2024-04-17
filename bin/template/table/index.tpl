import React, { useEffect, useState } from 'react';
import { Table } from 'antd';
import { ColumnsType, TablePaginationConfig } from 'antd/es/table';
import { FilterValue, SorterResult } from 'antd/es/table/interface';

// TODO 待定义具体的数据item类型，实际场景请将类型定义挪至对应的types文件中
interface ListItemType {}

const fetchData = async (pagination: TablePaginationConfig) => {
    // return axios.get('/api/cases', {
    //     params: {
    //         page: pagination.current,
    //         pageSize: pagination.pageSize,
    //     },
    // })
};

const {{name}}: React.FC<{}> = () => {
    const [list, setList] = useState<ListItemType[]>([]);
    const [pagination, setPagination] = useState<TablePaginationConfig>({
        current: 1,
        pageSize: 10,
        total: 0,
    });
    const [loading, setLoading] = useState(false);

    const columns: ColumnsType<ListItemType> = [
        // {
        //     title: 'Title',
        //     dataIndex: 'title',
        //     render(title, record) {
        //         return <a onClick={() => handlePreview(record as any)}>{title}</a>;
        //     },
        // },
    ];

    const getList = async (pagination: TablePaginationConfig) => {
        setLoading(true);
        const res = await fetchData(pagination).catch((err) => console.error(err));
        if (!res?.result) return;

        setLoading(false);
        //TODO list数据字段根据实际业务场景来确定
        setList(res.object.list);

        setPagination((p) => ({
            ...p,
            // total: res.data.total
            // TODO 接口返回total后更新total
        }));
    };

    const handleTableChange = (
        pagination: TablePaginationConfig,
        filters: Record<string, FilterValue | null>,
        sorter: SorterResult<ListItemType> | SorterResult<ListItemType>[],
    ) => {
        // TODO 根据实际业务场景组装filters, sorter等请求参数
        const newPagination = {
            current: pagination.current,
            pageSize: pagination.pageSize,
        };
        setPagination((p) => ({ ...p, ...newPagination }));
        getList(newPagination);
    };

    useEffect(() => {
        getList(pagination);
    }, []);

    return (
        <Table
            //TODO rowKey根据实际的场景来确定，
            rowKey="id"
            loading={loading}
            dataSource={list}
            columns={columns}
            pagination={{ ...pagination }}
            onChange={handleTableChange}
        ></Table>
    );
};

export default {{name}}