import React, { useState, useMemo, cloneElement, useEffect } from 'react';
import { Modal } from "antd";

interface IProps {
  title?: string;
  visible: boolean;
  onOk?: (data: any) => void; // TODO 待填充data的类型
  onCancel?: () => void;
}

// 支持组件内管理visible，也支持外部控制visible
const <%name%>: React.FC<IProps> = (props) => {
  const {
    title = "this is the default title of modal", // TODO 待更新默认title
    visible: propVisible,
    onOk,
    onCancel,
    children
  } = props;

  const [visible, setVisible] = useState(false);

  const triggerDom = useMemo(() => {
        if (!React.isValidElement(children)) return null;

        return cloneElement(children, {
            key: 'trigger',
            ...children.props,
            onClick: () => setVisible(true),
        });
    }, [children]);

  const handleOk = () => {
    const data = {}; // TODO 待填充data的数据
    typeof onOk === "function" && onOk(data);
  };

  const handleCancel = () => {
    setVisible(false);
    typeof onCancel === 'function' && onCancel();
  };

  useEffect(() => {
    if (typeof propVisible !== 'undefined') {
      setVisible(propVisible);
    }
  }, [propVisible]);

  return (
    <>
      {triggerDom}
    
      <Modal title={title} open={visible} onOk={handleOk} onCancel={handleCancel}>
        {/* TODO 内容待填充 */}
      </Modal>
    </>
  );
};

export default <%name%>