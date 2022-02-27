import React, { useState } from 'react';
import { Container, Card, Form, Button } from 'react-bootstrap';
import ipfs from "../ipfs";
import { useMetaMask } from "metamask-react";
import { ethers, utils } from 'ethers';
import { LEGOCADDEAL_ADDRESS, SALE_LEGOCADDEAL_ADDRESS } from '../contracts/address';

const legoCadDealAbi = require('../contracts/LegoCadDeal.json');
const saleLegoCadDealAbi = require('../contracts/SaleLegoCadDeal.json');

function Create() {
    const { account } = useMetaMask();
    const [previewImageSrc, setPreviewImageSrc] = useState('');
    const [uploadImageSrc, setUploadImageSrc] = useState('');


    const bufferedImage = (fileBlob) => {
        const reader = new FileReader();
        reader.readAsArrayBuffer(fileBlob);

        return new Promise((resolve) => {
            reader.onloadend = () => {
                setUploadImageSrc(reader.result);
                resolve();
            }
        });
    }

    const previewImage = (fileBlob) => {
        const reader = new FileReader();
        reader.readAsDataURL(fileBlob);
        return new Promise((resolve) => {
            reader.onload = () => {
                setPreviewImageSrc(reader.result);
                resolve();
            }
        });
    };

    function handleImageUpload(event) {
        const fileBlob = event.target.files[0];
        // if(fileBlob.size > (100 * 1024 * 1024)) {alert("Don't do that!")}
        previewImage(fileBlob)
            .then(() => {
                bufferedImage(fileBlob)
                    .catch((error) => {
                        console.error("image to buffer: ", error);
                    });
            })
            .catch((error) => {
                console.error("preview image: ", error);
            });
    }

    function submitHandler(event) {
        event.preventDefault();
        // ethers
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const legoCadDealContract = new ethers.Contract(LEGOCADDEAL_ADDRESS, legoCadDealAbi, provider);
        const saleLegoCadDealContract = new ethers.Contract(SALE_LEGOCADDEAL_ADDRESS, saleLegoCadDealAbi, provider);
        const signer = provider.getSigner();
        const contractWithSigner = legoCadDealContract.connect(signer);

        // meta info
        const title = document.getElementById('title').value;
        const desc = document.getElementById('description').value;
        const price = document.getElementById('price').value;

        const minting = async () => {
            const imageSrcToHash = await ipfs.add(uploadImageSrc)
                .catch((error) => {
                    console.log("(IPFS) add image: ", error);
                });

            const metadata = {
                title: title,
                description: desc,
                price: price,
                creator: account,
                image: "https://ipfs.io/ipfs/" + imageSrcToHash.path,
            }

            let metadataToHash = await ipfs.add(JSON.stringify(metadata))
                .catch((error) => {
                    console.log("(IPFS) add metadata: ", error);
                });

            metadataToHash = "https://ipfs.io/ipfs/" + metadataToHash.path;

            const tokenId = await contractWithSigner.mint(account, metadataToHash)
                .then(async (response) => {
                    const receipt = await response.wait();
                    const event = await receipt.events.find(x => x.event === "Transfer");
                    return parseInt(event.args.tokenId._hex, 16);
                    // const events = receipt.events.find(x => x.args["tokenId"]._hex);
                })
                .catch((err) => {
                    console.error(err);
                });
            await contractWithSigner.setApprovalForAll(SALE_LEGOCADDEAL_ADDRESS, true); // 판매 허가
            console.log("tokenId", tokenId);

            const saleContractWithSigner = saleLegoCadDealContract.connect(signer);
            await saleContractWithSigner.setTokenPrice(tokenId, price);
        }
        minting();
        // document.location.replace('/world');
    }

    return (
        <Container className='centered'>
            <Card style={{ width: '18rem' }}>
                <Card.Header className='centered'>NFT 생성</Card.Header>
                <Card.Body className="centered">
                    <div className="preview" id="preview">
                        {previewImageSrc && <img src={previewImageSrc} alt="" />}
                    </div>
                </Card.Body>
                <Card.Body className="centered">
                    <Form onSubmit={submitHandler}>
                        <Form.Group>
                            <Form.Label className="label centered" id="label" htmlFor="input">
                                <Button variant="primary" className="inner" id="inner" disabled>파일 업로드</Button>
                            </Form.Label>
                            <Form.Control id="input" className="input" accept="image/*" type="file" onChange={handleImageUpload} required={true} hidden={true} />
                        </Form.Group>

                        <Form.Group className="mb-3">
                            <Form.Label>
                                제목
                            </Form.Label>
                            <Form.Control id="title" type="text" placeholder="Title" required={true} />
                        </Form.Group>

                        <Form.Group className="mb-3">
                            <Form.Label>
                                설명
                            </Form.Label>
                            <Form.Control id="description" as="textarea" placeholder="Description" required={true} />
                        </Form.Group>

                        <Form.Group className="mb-3">
                            <Form.Label>
                                가격
                            </Form.Label>
                            <Form.Control id="price" type="text" placeholider="Price" required={true} />
                        </Form.Group>

                        <Form.Group className="centered">
                            <Button variant="primary" type="submit">생성</Button>
                        </Form.Group>
                    </Form>
                </Card.Body>
            </Card>
        </Container>
    )
}

export default Create;