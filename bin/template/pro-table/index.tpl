import React, { useRef } from "react";
import { Image, Button } from "antd";
import ProTable from "@ant-design/pro-table";
import type { ProColumns, ActionType } from "@ant-design/pro-table";

// TODO ListItem根据实际业务场景定义类型，实际开发时将此定义挪至对应的types文件中
interface ListItem {
  image_url: string;
}
// TODO FetchParmas根据实际业务场景定义类型，实际开发时将此定义挪至对应的types文件中
interface FetchParmas {}

// TODO formatParams根据实际业务场景定义类型，实际开发时将此定义挪至对应的utils文件中
const formatParams = (params: FetchParmas, sort: Record<string, any>) => ({});

// TODO formatParams根据实际业务场景定义类型，实际开发时将此定义挪至对应的service文件中
const fetchList = async (params: any) => {};

const {{name}}: React.FC<any> = () => {
  const actionRef = useRef<ActionType>();

  const columns: ProColumns<ListItem>[] = [
    {
      title: "Image",
      dataIndex: "image_url",
      hideInSearch: true,
      width: 60,
      render: (_, row) => {
        return <Image width={50} src={row.image_url} />;
      },
    },
  ];

  const request = async (params: FetchParmas, sort: Record<string, any>) => {
    if (!Object.keys(sort)?.length) {
      sort = {
        id: "descend",
      };
    }

    const formattedParams = formatParams(params, sort) || {};
    const ret = await fetchList(formattedParams).catch((err) =>
      console.log(err)
    );

    return {
      data: ret?.object?.list || [],
      sucess: true,
      total: ret?.object?.total || 0,
    };
  };

  return (
    <>
      <ProTable<ListItem>
        actionRef={actionRef}
        // TODO 根据实际业务场景定义
        // TODO headerTitle="Header Title"
        // 根据实际业务场景定义rowKey，rowKey必须唯一且稳定
        rowKey="id"
        request={request}
        columns={columns}
        pagination={{
          showQuickJumper: true,
        }}
        // TODO 根据实际业务场景定义
        toolBarRender={() => [<Button key="new">New</Button>]}
      />
    </>
  );
};

export default {{name}};