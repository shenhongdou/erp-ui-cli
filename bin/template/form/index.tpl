import { Form } from 'antd';
import { useLocation } from 'umi';
import * as H from 'history';

// 这里填充prop的类型，如果没有可以删掉IProp定义和下面的prop:IProps
interface IProps {

}

const <%name%> = (props:IProps) => {
  const location = useLocation() as H.Location<undefined> & { query: Record<string, any> };
    const [form] = Form.useForm();

    const handleFinish = (values: any) => {};

    return (
        <Form
            form={form}
            // 如果需要初始化query数据到表单中，需要设置initialValues，否则删掉下一行代码
            initialValues={location.query}
            onFinish={handleFinish}
        >
            <Form.Item label="" name="">
                form content
            </Form.Item>
        </Form>
    );
};

export default <%name%>;
