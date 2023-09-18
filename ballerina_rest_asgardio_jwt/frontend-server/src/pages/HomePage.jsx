import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthContext } from "@asgardeo/auth-react";
import CustomButton from '../components/CustomButton';

export default function HomePage() {
  const { state } = useAuthContext();

  return (
    !state.isAuthenticated ?
      <GuestHomePage/>
      :
      <LoggedUserHomePage/>
  );
}

function GuestHomePage() {
    const {signIn} = useAuthContext();

    return <React.Fragment>
          <CustomButton color="primary" onClick={() => signIn()} disabled={false} label={"Log In"} size={'large'}/>
      </React.Fragment>
}

function LoggedUserHomePage() {
    const { signOut } = useAuthContext();
    const navigate = useNavigate();
    const { state } = useAuthContext();

    const logout = () => {
      try {
        signOut();
      } catch (error) {
        console.log(error);
      }
    };

  return <React.Fragment>
        <CustomButton color="primary" onClick={() => logout()} disabled={false} label={"Log Out"} size={'large'}/>
        <CustomButton color="primary" onClick={() => {navigate("/orders")}} disabled={false} label={"order"} size={'large'}/>
        <CustomButton color="primary" onClick={() => {navigate("/create-order")}} disabled={false} label={"Create a Order"} size={'large'}/>
        <CustomButton color="primary" onClick={() => {navigate("/cargos")}} disabled={false} label={"cargo"} size={'large'}/>
        <CustomButton color="primary" onClick={() => {navigate("/create-cargo")}} disabled={false} label={"Submit a Cargo"} size={'large'}/>
    </React.Fragment >
}
