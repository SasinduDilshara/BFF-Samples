import React from 'react';
import { useNavigate } from 'react-router-dom';
import CustomButton from '../components/CustomButton';

export default function HomePage() {
    const navigate = useNavigate();

  return <React.Fragment>
        <CustomButton color="primary" onClick={() => {navigate("/orders")}} disabled={false} label={"order"} size={'large'}/>
        {/* <CustomButton color="primary" onClick={() => {navigate("/create-order")}} disabled={false} label={"Create a Order"} size={'large'}/> */}
    </React.Fragment >
}
