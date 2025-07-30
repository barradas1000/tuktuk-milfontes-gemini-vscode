
import React, { useState } from 'react';
import { Dialog, DialogContent, DialogTrigger } from '@/components/ui/dialog';
import { AnimatePresence, motion } from 'framer-motion';
import { ChevronLeft, ChevronRight, X } from 'lucide-react';

const images = [
  { src: '/lovable-uploads/365cc092-1790-4b63-a689-2a9b96502d5e.png', alt: 'Diversão Garantida' },
  { src: '/lovable-uploads/47a59b02-cbe5-4103-ac4c-ea39946a7b96.png', alt: 'Vista Aérea de Milfontes' },
  { src: '/lovable-uploads/a736c163-97f6-47cb-80c1-b2ed8d1bf580.png', alt: 'Forte de Milfontes' },
  { src: '/lovable-uploads/bc9c590b-26bf-4d4d-a27c-3e917afef291.png', alt: 'Pôr do Sol em Milfontes' },
  { src: '/lovable-uploads/ddc85a0b-4a74-44e3-a0a6-bed937a5a686.png', alt: 'Tuk-Tuk com Cobertura' },
  { src: '/lovable-uploads/praia_do_farol_main_1_1024_2500.jpg', alt: 'Praia do Farol' },
  { src: '/lovable-uploads/foz do mira.jpg', alt: 'Foz do Rio Mira' },
  { src: '/lovable-uploads/praia das furnas.jpg', alt: 'Praia das Furnas' },
];

const ImageGallery = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [currentIndex, setCurrentIndex] = useState(0);

  const openModal = (index: number) => {
    setCurrentIndex(index);
    setIsOpen(true);
  };

  const closeModal = () => {
    setIsOpen(false);
  };

  const goToPrevious = () => {
    setCurrentIndex((prevIndex) => (prevIndex === 0 ? images.length - 1 : prevIndex - 1));
  };

  const goToNext = () => {
    setCurrentIndex((prevIndex) => (prevIndex === images.length - 1 ? 0 : prevIndex + 1));
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {images.map((image, index) => (
          <motion.div
            key={index}
            className="overflow-hidden rounded-lg cursor-pointer"
            whileHover={{ scale: 1.05 }}
            transition={{ duration: 0.3 }}
            onClick={() => openModal(index)}
          >
            <img src={image.src} alt={image.alt} className="w-full h-full object-cover" />
          </motion.div>
        ))}
      </div>

      <AnimatePresence>
        {isOpen && (
          <Dialog open={isOpen} onOpenChange={setIsOpen}>
            <DialogContent className="p-0 max-w-4xl bg-transparent border-0">
              <motion.div
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.9 }}
                className="relative"
              >
                <img
                  src={images[currentIndex].src}
                  alt={images[currentIndex].alt}
                  className="w-full h-auto max-h-[80vh] object-contain rounded-lg"
                />
                <button
                  onClick={closeModal}
                  className="absolute top-2 right-2 text-white bg-black/50 rounded-full p-2 hover:bg-black/80 transition-colors"
                >
                  <X size={24} />
                </button>
                <button
                  onClick={goToPrevious}
                  className="absolute top-1/2 left-2 -translate-y-1/2 text-white bg-black/50 rounded-full p-2 hover:bg-black/80 transition-colors"
                >
                  <ChevronLeft size={32} />
                </button>
                <button
                  onClick={goToNext}
                  className="absolute top-1/2 right-2 -translate-y-1/2 text-white bg-black/50 rounded-full p-2 hover:bg-black/80 transition-colors"
                >
                  <ChevronRight size={32} />
                </button>
              </motion.div>
            </DialogContent>
          </Dialog>
        )}
      </AnimatePresence>
    </div>
  );
};

export default ImageGallery;
