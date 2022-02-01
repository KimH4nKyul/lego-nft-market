import React from 'react';
import { Link } from 'react-router-dom';

function Home() {
    console.log("Home");
    return (
        <div>
            <div className="centered">
                <img src="images/lego_sample.jpg" alt="" />
            </div>
            <div className="centered">
                <div className="th_b_t_buitton buttonMaxSiz" ><Link to="/world">Entrance</Link></div>
            </div>
            <div className="centered">
                <b>
                    LEGO CAD DEAL은 레고 아티스트 혹은 레고를 좋아하는 사람들이 자신의 작품을 <br />
                    NFT로 전시하는 갤러리입니다. <p />
                    자신이 만든 작품의 소유권을 인정받을 수 있습니다. <p />
                    다른 사람의 작품을 직접 만들어 보고 싶다면 NFT를 구매해 보세요. <br />
                    도면이 함께 제공될 것입니다. <p />
                    서비스 이용을 위해선 <a rel="noopener noreferrer" target="_blank" href="https://metamask.io/download/">메타마스크</a>가 필요합니다. <br />
                    메타마스크를 지원하는 브라우저인지 확인하세요.<p />
                    이용 준비가 되었다면, 상단의 <u>Entrance</u> 버튼을 클릭하세요.
                    <img src="images/support.png" alt="" />
                </b>
            </div>
        </div >
    );
}

export default Home;